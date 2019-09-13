data "aws_route53_zone" "selected" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "nfs_record" {
  name    = "nfs.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
  zone_id = data.aws_route53_zone.selected.zone_id
  records = [aws_lb.nfs_lb.dns_name]
}
