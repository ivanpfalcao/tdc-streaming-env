# TDC Streaming Demo

Repositório contendo os códigos do ambiente apresentado na palestra "3 bilhões de registros por dia em near real time com Apache Druid" - TDC São Paulo 2024

## Dependências

* **Cluster [`Kubernetes`](https://kubernetes.io/) compatível (funciona com [`minikube`](https://minikube.sigs.k8s.io/))**
* **[`Kubectl`](https://kubernetes.io/pt-br/docs/tasks/tools/)**
* **[`Helm`](https://helm.sh/)**
* **Ambiente compatível com bash**


## Conteúdo das Pastas

### `app`

* **[`buscacep`](app/buscacep/)**
    * `buscacep.py`: Script Python responsável por buscar informações de CEP, utilizando a biblioteca brazilcep.
    * `requirements.txt`: Lista as dependências Python necessárias para executar o script `buscacep.py`.

* **[`druid`](app/druid/)**
    * `druid-spark-spec.json`, `druid-spec.json`: Arquivos de configuração do Druid para as tabelas em tempo real provenientes do Kafka.

* **[`grafana`](app/grafana/)**
    * `TDC Dashboard-1726334351048.json`: Dashboard Grafana para acessar os dados provenientes do Druid. Depende do conector de Druid a ser instalado no Grafana.

* **[`nifi`](app/nifi/)**
    * `kafka-tests.json`: Arquivo de fluxo do Nifi que gera dados JSON mockados para o projeto e os envia para o Kafka.

* **[`spark-enrichment`](app/spark-enrichment/)**
    * `ceps_brazil_real_data.csv`: Conjunto de dados contendo informações de CEPs brasileiros, precisa ser transferido para a pasta s3://auxdata/cep do storage S3 compatible correspondente (para esse projeto Minio).
    * `config.yaml`: Arquivo de configuração para o processo de enriquecimento de dados com o Apache Spark, definindo parâmetros como fontes de dados, transformações a serem aplicadas e destinos dos dados enriquecidos.
    * `containers/`:
        * Contém scripts e um Dockerfile para buildar a aplicação Spark em um contêiner Docker.
    * `k8s/`: 
        * Contém scripts e arquivos YAML para implantar e gerenciar a aplicação Spark em um cluster Kubernetes, permitindo escalar horizontalmente o processamento de dados e garantir alta disponibilidade.
    * `requirements.txt`: Lista as dependências Python para a aplicação Spark.
    * `spark-enrichment.py`: Script Python principal para o processo de enriquecimento de dados com Spark.

### `environment`

* **[`kafka-strimzi`](environment/kafka-strimzi/)**
    * Scripts e arquivos YAML para implantar e gerenciar o Apache Kafka utilizando o Strimzi Operator em um cluster Kubernetes.

* **[`akhq`](environment/akhq/)**
    * Scripts e arquivos YAML para implantar o AKHQ, uma interface web para gerenciar o Apache Kafka, facilitando a criação, configuração e monitoramento de tópicos, produtores e consumidores.

* **[`aws-cli`](environment/aws-cli/)**
    * Scripts e arquivos YAML para implantar a AWS CLI, a interface de linha de comando para interagir com os serviços da Amazon Web Services, permitindo gerenciar recursos na nuvem, como instâncias EC2, buckets S3 e outros. Utilizamos o aws-cli para se conectar com qualquer storage S3 like, como o MinIO.

* **[`minio`](environment/minio/), [`minio-bitnami`](environment/minio-bitnami/)**
    * Duas alternativas para implantar o MinIO, um sistema de armazenamento de objetos compatível com a API S3 da Amazon, que pode ser utilizado para armazenar e servir arquivos e dados de forma escalável e confiável. Para o projeto utilizamos o [`minio nativo`](environment/minio/).

* **[`druid`](environment/druid/)**
    * Scripts e arquivos YAML para instalar e configurar o Apache Druid e seus componentes relacionados (ZooKeeper, PostgreSQL).

* **[`grafana-custom`](environment/grafana-custom/)**
    * Scripts e arquivos YAML para construir e implantar uma versão customizada do Grafana. Para esse projeto utilizamos a versão nativa do Grafana, instalando o conector de Druid manualmente.

* **[`nifi`](environment/nifi/)**
    * Scripts e arquivos YAML para implantar o Apache NiFi utilizando o Helm.

* **[`digital-ocean`](environment/digital-ocean/)**
    * Scripts para configurar um storage class em um cluster DigitalOcean Kubernetes. Necessário para o funcionamento em clusters de alguns vendors.

* **[`trino`](environment/trino/)**
    * Scripts e arquivos YAML para implantar o Trino, um mecanismo de consulta SQL distribuído para consultar grandes conjuntos de dados em diversas fontes, permitindo realizar análises em tempo real em dados armazenados em diferentes sistemas, como bancos de dados relacionais, sistemas de arquivos e outros. Não utilizado nessa demo, mas acho interessante manter o código para implementação.       