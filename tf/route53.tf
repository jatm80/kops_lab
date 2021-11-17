resource "aws_route53_record" "ingress" {
  zone_id = var.r53_zoneid
  name    = var.appname
  type    = "CNAME"
  ttl     = "60"
  records        = [data.local_file.ingress_hostname.content]
}
