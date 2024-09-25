resource "tls_private_key" "rsakey" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "public_key" {
    key_name="Webserver_key"
    public_key = tls_private_key.rsakey.public_key_openssh
  
}

output "private_key" {
    # value = tls_private_key.rsakey.private_key_pem
    value = tls_private_key.rsakey.private_key_pem
    sensitive = true
}

