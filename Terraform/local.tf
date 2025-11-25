locals {
  common_tags         = var.tags
  vpc_name            = "${var.base_name}-vpc"
  public_subnet_name  = "${var.base_name}-public-subnet-1a"
  private_subnet_name = "${var.base_name}-private-subnet-1a"
  igw_name            = "${var.base_name}-igw"
  public_rt_name      = "${var.base_name}-public-rt"
  private_rt_name     = "${var.base_name}-private-rt"
  eip_name            = "${var.base_name}-eip"
  eni_name            = "${var.base_name}-eni"
  sg_name             = "${var.base_name}-sg"
  ec2_name            = "${var.base_name}-ec2"
  nat_gateway_name    = "${var.base_name}-nat-gateway"
}