docker run -d -p 80:4141 custom-atlantis:latest server \
--gh-user=kimdragon50 \
--gh-token="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" \
--repo-allowlist='*' \
--repo-config=/usr/local/bin/repos.yaml