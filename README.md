# WebApplication
Como utilizar o Makefile<br>
Os comandos possíveis para o Makefile são:<br>
make configure : Este comando executa o aws configure para realizara configurações da AWS Cloud.<br>
make plan : Este comando executa o terraform plan do projeto (realiza a criação de um output com tudo que será criado na cloud)<br>
make apply : Este comando executa o terraform apply do projeto (realiza toda a criação da infraestrutura criada)<br>
make destroy : Este comando executa o terraform destroy do projeto (destroi toda a infraestrutura criada)<br>

05/05/2022 - Realizei uma otimização agora é só necessario realizar o aws configure que o packer tb é ativado... não é mais necessario realizar o input das credenciais da aws novamente nas variáveis após o aws configure.

13/05/2022 - Realizada a criação do makefile (para conhecer os comandos digite no cmd make), alterado a linguagem de programação utilizada para a criação da imagem packer de json para hcl.

15/05/2022 - Criação da key pair otimizada, agora ele cria o arquivo .pem na raiz do projeto, otimizado os outputs (criado arquivos para facilitar a leitura).
