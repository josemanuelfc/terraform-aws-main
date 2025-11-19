# Configuramos el proveedor de AWS
provider "aws" {
  region =  "eu-west-1"
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_ejemplo_01" {
  ami           = "ami-0fc970315c2d38f01"
  instance_type = "t2.small"
  key_name      = "profesor01"
  tags = {
    Name = "instancia_ejemplo_01"
  }
}

# No podremos conectarnos a la instancia porque no tiene grupo de seguridad
