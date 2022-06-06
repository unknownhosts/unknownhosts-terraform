# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
# 리소스를 파일 하나로 관리할 거면 여기에

# ##############################################################################################################
# EKS
# create EKS cluster & node groups
# ##############################################################################################################
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks" {

  source          = "../../../../../../../modules/eks"
  
  cluster_name    = "${var.project_name}-${var.resource_name}-${var.environment_name}-eks-cluster"
  cluster_version = "1.22"
  subnets         = [data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[0],
                     data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[1],
                     data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[2],
                     data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[3],
                     data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[4],
                     data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[5]
  ]

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc[0].vpc_id

  node_groups = {
  
    ingress = {
        name             = "${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-eks-node"
        desired_capacity = 1
        max_capacity     = 1
        min_capacity     = 1
        subnets = [data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[0],
                    data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[1]
        ]
        instance_type = "t3.large"

        k8s_labels = {
            nodegroup = "ingress"
        }

        launch_template_id      = aws_launch_template.ingress.id
        launch_template_version = aws_launch_template.ingress.default_version

        additional_tags = {
        CustomTag = "FRONTEND"
        Name = "${var.project_name}-${var.resource_name}-${var.environment_name}-ingress-eks-node"
        }
    }
      
    app = {
        name             = "${var.project_name}-${var.resource_name}-${var.environment_name}-app-eks-node"
        desired_capacity = 1
        max_capacity     = 1
        min_capacity     = 1
        subnets = [data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[2],
                    data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[3]
        ]
        instance_type = "t3.large"

        k8s_labels = {
            nodegroup = "app"
        }

        launch_template_id      = aws_launch_template.app.id
        launch_template_version = aws_launch_template.app.default_version

        additional_tags = {
        CustomTag = "BACKEND"
        Name = "${var.project_name}-${var.resource_name}-${var.environment_name}-backend-eks-node"
        }
    }
    
    mgmt = {
        name             = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-eks-node"
        desired_capacity = 1
        max_capacity     = 1
        min_capacity     = 1
        subnets = [data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[4],
                    data.terraform_remote_state.vpc.outputs.vpc[0].private_subnets[5]
        ]
        instance_type = "t3.large"

        k8s_labels = {
            nodegroup = "mgmt"
        }
        
        launch_template_id      = aws_launch_template.mgmt.id
        launch_template_version = aws_launch_template.mgmt.default_version

        additional_tags = {
        CustomTag = "mgmt"
        Name = "${var.project_name}-${var.resource_name}-${var.environment_name}-mgmt-eks-node"
        }
    }
  }
}

