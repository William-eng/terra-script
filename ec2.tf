resource "aws_key_pair" "grp8_kp" {
  key_name   = "keymechterr" # New Key Pair Name 
  public_key = tls_private_key.grp8_kp.public_key_openssh
}

# Generate a new private key
resource "tls_private_key" "grp8_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

#To create a file or folder to save your Private Key 
resource "local_file" "grp8_kp" {
  content  = tls_private_key.grp8_kp.private_key_pem
  filename = "keymechterr.pem" # Save as a .pem file 
}
#Create EC2 Instance with NGINX installation via user_data
resource "aws_instance" "grp6_nginx_server" {
  #depends_on                  = [aws_security_group.g8sg, aws_subnet.g8public]
  ami                         = "ami-0e86e20dae9224db8" # Amazon Ubuntu AMI
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.g8public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.grp8_kp.key_name

  vpc_security_group_ids = [aws_security_group.group_eight.id] # Attach correct SG

  # Configure Userdata to Install Nginx on Instance Launch
  user_data_replace_on_change = true

  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
git clone https://github.com/devopsthepracticalway/bootcamp-1-project-1a
sudo mv bootcamp-1-project-1a/*  /var/www/html/
EOF


  tags = {
    Name = "devops-group-8"
  }
}