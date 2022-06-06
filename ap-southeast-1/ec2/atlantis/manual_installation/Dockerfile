FROM ghcr.io/runatlantis/atlantis:latest

RUN apk add aws-cli curl

ARG TERRAGRUNT

RUN set -eux \
	&& if [ "${TERRAGRUNT}" = "latest" ]; then \
		TERRAGRUNT="$( \
			curl -L -sS https://github.com/gruntwork-io/terragrunt/releases \
			| tac | tac \
			| grep -Eo '"/gruntwork-io/terragrunt/releases/tag/v?[0-9]+\.[0-9]+\.[0-9]+"' \
			| grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' \
			| sort -V \
			| tail -1 \
		)"; \
	fi \
	&& curl -L -sS "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT}/terragrunt_linux_amd64" -o /usr/local/bin/terragrunt \
	&& chmod +x /usr/local/bin/terragrunt \
	&& terragrunt --version | grep "v${TERRAGRUNT}"