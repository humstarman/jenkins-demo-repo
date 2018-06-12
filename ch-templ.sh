#!/bin/bash
sed -i s/"{{.namespace}}"/"${NAMESPACE}"/g ./manifest/controller.yaml
sed -i s/"{{.project}}"/"${PROJECT}"/g ./manifest/controller.yaml
sed -i s/"{{.local.registry}}"/"${LOCAL_REGISTRY}"/g ./manifest/controller.yaml
sed -i s/"{{.tag}}"/"${TAG}"/g ./manifest/controller.yaml
exit 0
