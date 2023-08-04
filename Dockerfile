FROM registry.ci.openshift.org/openshift/release:golang-1.20 as builder
WORKDIR /ingress-operator
COPY . .
RUN make build

FROM quay.io/openshift/origin-base:4.14
COPY --from=builder /ingress-operator/ingress-operator /usr/bin/
COPY manifests /manifests
ENTRYPOINT ["/usr/bin/ingress-operator"]
LABEL io.openshift.release.operator="true"
LABEL io.k8s.display-name="OpenShift ingress-operator" \
      io.k8s.description="This is a component of OpenShift Container Platform and manages the lifecycle of ingress controller components." \
      maintainer="Miciah Masters <mmasters@redhat.com>"
