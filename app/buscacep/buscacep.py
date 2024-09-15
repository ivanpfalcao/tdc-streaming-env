import brazilcep
import csv
import time
from brazilcep import get_address_from_cep, WebService

# List of CEPs provided by you
ceps = [
	"01001-000", "01310-000", "01415-000", "01519-000", "02011-000","02222-000", "03009-000", "03320-000", 
	"04002-000", "04510-000","05017-000", "05508-000", "06013-000", "07074-000", "08050-000","08121-000", 
	"09015-000", "09210-000", "09510-000", "09710-000","11015-000", "11410-000", "13010-000", "14020-000", 
	"15015-000","16015-000", "17012-000", "18010-000", "19010-000", "20040-000","20500-000", "21010-000", 
	"22020-000", "23010-000", "24010-000","26010-000", "28010-000", "30010-000", "31010-000", "32010-000",
	"35010-000", "36010-000", "37010-000", "38010-000", "40010-000","41010-000", "42010-000", "44010-000", 
	"45010-000", "48010-000","50010-000", "52010-000", "53010-000", "55010-000", "56010-000","57010-000", 
	"58010-000", "59010-000", "60010-000", "61010-000","62010-000", "63010-000", "64010-000", "65010-000", 
	"66010-000","67010-000", "68010-000", "69010-000", "70010-000", "71010-000","72010-000", "73010-000", 
	"74010-000", "75010-000", "76010-000","77010-000", "78010-000", "79010-000", "80010-000", "81010-000",
	"82010-000", "83010-000", "84010-000", "85010-000", "86010-000","87010-000", "88010-000", "89010-000", 
	"90010-000", "91010-000","92010-000", "93010-000", "94010-000", "95010-000", "96010-000","97010-000", 
	"98010-000", "99010-000", "10010-000", "11010-000","12010-000", "13010-000", "14010-000", "15010-000", 
	"16010-000","17010-000", "18010-000", "19010-000", "20010-000", "21010-000","22010-000", "23010-000", 
	"24010-000", "25010-000", "26010-000","27010-000", "28010-000", "29010-000", "30010-000", "31010-000"
]

# Define the output file
output_file = "ceps_brazil_real_data.csv"

# Write the header row
with open(output_file, mode='w', newline='') as file:
    writer = csv.writer(file, delimiter=';')
    writer.writerow(["cep", "uf", "cidade", "pais", "endereco", "distrito"])

# Fetch real data for each CEP
for cep in ceps:
    success = False
    retries = 3  # Number of retries before giving up
    for attempt in range(retries):
        try:
            address_data = brazilcep.get_address_from_cep(cep, webservice=WebService.VIACEP)
            print(address_data)
            # Safely extract the fields, using default values if not present
            uf = address_data.get("uf", "N/A")
            cidade = address_data.get("city", "N/A")
            logradouro = address_data.get("street", "N/A")
            distrito = address_data.get("district", "N/A")
            
            # Write the result to the file
            with open(output_file, mode='a', newline='') as file:
                writer = csv.writer(file, delimiter=';')
                writer.writerow([cep, uf, cidade, "Brasil", logradouro, distrito])
            
            success = True
            break  # Break the loop if the request was successful
        except Exception as e:
            print(f"Error fetching data for {cep} on attempt {attempt+1}: {e}")
            if "429" in str(e):  # If it's a rate limit error, wait before retrying
                time.sleep(15)  # Increased wait time to 15 seconds before retrying
            else:
                break  # If it's another error, don't retry

    if not success:
        print(f"Failed to fetch data for {cep} after {retries} attempts.")
