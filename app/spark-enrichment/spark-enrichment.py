import yaml
import argparse
from pyspark.sql import SparkSession
from pyspark.sql.functions import to_json, struct, from_json, col
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType

# Helper function to map string type names to Spark data types
def get_spark_type(data_type):
	if data_type == "string":
		return StringType()
	elif data_type == "integer":
		return IntegerType()
	elif data_type == "double":
		return DoubleType()
	else:
		raise ValueError(f"Unsupported data type: {data_type}")

# Argument parser to get config file path from command-line arguments
parser = argparse.ArgumentParser(description="Spark Enrichment Application")
parser.add_argument("--config_file", type=str, required=True, help="Path to the YAML configuration file")
args = parser.parse_args()

# Load configuration from YAML file
with open(args.config_file, 'r') as stream:
	config = yaml.safe_load(stream)

# Define the schema for MinIO data based on the YAML configuration
print("Config File: ")
print(config)

schema = StructType([
	StructField(field['name'], get_spark_type(field['type']), True)
	for field in config['schema']['fields']
])

# Initialize SparkSession
spark = SparkSession.builder \
	.appName("Kafka-Enrichment") \
	.getOrCreate()

# Set up s3-storage configuration
spark._jsc.hadoopConfiguration().set("fs.s3a.endpoint", config['s3-storage']['endpoint'])
spark._jsc.hadoopConfiguration().set("fs.s3a.access.key", config['s3-storage']['accessKey'])
spark._jsc.hadoopConfiguration().set("fs.s3a.secret.key", config['s3-storage']['secretKey'])
spark._jsc.hadoopConfiguration().set("fs.s3a.connection.ssl.enabled", "true")
spark._jsc.hadoopConfiguration().set("fs.s3a.path.style.access", "true")

# Read data from s3-storage storage with the defined schema
aux_df_options = config['aux-table']['options']
aux_df_format = config['aux-table']['format']
s3_storage_df = spark.read.format(aux_df_format).options(**aux_df_options).load(f"{config['aux-table']['path']}")

# Set up Kafka source with generic options
kafka_input_options = config['kafkaInput']['options']
kafka_df = spark.readStream.format("kafka").options(**kafka_input_options).load()

processed_df = kafka_df.select(
    col("key").cast("string").alias("kafka_key"),
    col("value").cast("string").alias("kafka_value"),
    col("topic").alias("kafka_topic"),
    col("partition").alias("kafka_partition"),
    col("offset").alias("kafka_offset"),
    col("timestamp").alias("kafka_timestamp")
)

json_df = processed_df.select(
    from_json(col("kafka_value"), schema).alias("json_data"),
    col("kafka_key"),
    col("kafka_topic"),
    col("kafka_partition"),
    col("kafka_offset"),
    col("kafka_timestamp")
).select("json_data.*", "kafka_key", "kafka_topic", "kafka_partition", "kafka_offset", "kafka_timestamp")


# Perform left join based on the keys specified in the YAML configuration
join_keys = config['join']['keys']
joined_df = json_df.join(s3_storage_df, on=join_keys, how='left')

# Convert the joined data to JSON format
output_df = joined_df.select(to_json(struct([col(c) for c in joined_df.columns])).alias("value"))

# Write the output to Kafka with generic options
kafka_output_options = config['kafkaOutput']['options']
query = output_df.writeStream.format("kafka") \
	.options(**kafka_output_options) \
	.option("checkpointLocation", config['checkpointLocation']) \
	.start()

# Await termination
query.awaitTermination()
