variable "vpc_cidr{
    defaults = "192.168.0.0/16"
}
variable "project" {
    defaults = "cbz" 
} 
variable "env" {
    defaults = "dev"
} 
variable "private_subnet_cidr" {
    defaults = "192.168.0.0/24"
} 
variable "public_subnet_cidr" {
    defaults = "192.168.0.0/24"
} 
