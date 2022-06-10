docker run -d -p 80:4141 custom-atlantis:latest server \
--gh-user=kimdragon50 \
--gh-token="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" \
--repo-allowlist='*' \
--repo-config=/usr/local/bin/repos.yaml
