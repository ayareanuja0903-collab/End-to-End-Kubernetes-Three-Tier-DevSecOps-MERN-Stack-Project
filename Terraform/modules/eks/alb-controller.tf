############################################################
# AWS Load Balancer Controller IAM Policy
############################################################

data "http" "aws_load_balancer_controller_policy" {

  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

}


resource "aws_iam_policy" "aws_load_balancer_controller" {

  name = "AWSLoadBalancerControllerIAMPolicy"

  policy = data.http.aws_load_balancer_controller_policy.response_body

}