# Configuramos el proveedor de AWS
provider "aws" {
  region = "eu-west-1"
}

# Obtenemos la VPC por defecto
data "aws_vpc" "default" {
  default = true
}

# Creamos un grupo de seguridad
resource "aws_security_group" "sg_ejemplo_02" {
  name        = "sg_ejemplo_02"
  description = "Grupo de seguridad para la instancia de ejemplo 02"
  vpc_id      = data.aws_vpc.default.id   # ← obligatorio

  # Reglas de entrada
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2
resource "aws_instance" "instancia_ejemplo_02" {
  ami               = "ami-0fc970315c2d38f01"
  instance_type     = "t2.small"
  key_name          = "profesor01"

  # CORRECTO: asociar mediante ID, no nombre
  vpc_security_group_ids = [aws_security_group.sg_ejemplo_02.id]

  tags = {
    Name = "instancia_ejemplo_02"
  }
}

# Output con la IP pública
output "ip_publica" {
  value = aws_instance.instancia_ejemplo_02.public_ip
}

}
