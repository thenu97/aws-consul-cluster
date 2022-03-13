resource "aws_vpc" "snowplow_vpc" {
    cidr_block           =  var.vpc_cidr_block
    enable_dns_hostnames = true
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "snowplow_public_subnet" {
    count             = length(data.aws_availability_zones.available.names)
    vpc_id            = aws_vpc.snowplow_vpc.id
    cidr_block        = cidrsubnet(aws_vpc.snowplow_vpc.cidr_block, 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
}
