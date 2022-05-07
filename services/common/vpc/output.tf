output lincoln_vpc_id {
    value = module.vpc.vpc_id
}

/* 

############################################################################################################################
##    DEV
############################################################################################################################

output dev_public_subnet_id {
    value = module.vpc.dev_public_subnets
}

output dev_webwas_private_subnet_id {
    value = module.vpc.dev_webwas_private_subnets
}

output dev_db_private_subnet_id {
    value = module.vpc.dev_db_private_subnets
}

############################################################################################################################
##    QA
############################################################################################################################

output qa_public_subnet_id {
    value = module.vpc.qa_public_subnets
}

output qa_webwas_private_subnet_id {
    value = module.vpc.qa_webwas_private_subnets
}

output qa_db_private_subnet_id {
    value = module.vpc.qa_db_private_subnets
}

############################################################################################################################
##    DEV/QA
############################################################################################################################

output devqa_mgmt_private_subnet_id {
    value = module.vpc.devqa_mgmt_private_subnets
}
 */
