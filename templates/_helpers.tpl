{{/*
Expand the name of the chart.
*/}}
{{- define "_helpers.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "_helpers.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "_helpers.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "_helpers.labels" -}}
{{ include "_helpers.selectorLabels" . }}
helm.sh/chart: {{ include "_helpers.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "_helpers.selectorLabels" -}}
app.kubernetes.io/name: {{ include "_helpers.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service name
*/}}
{{- define "_helpers.service.name" -}}
service-{{ include "_helpers.fullname" . }}
{{- end }}

{{/*
Ingress name
*/}}
{{- define "_helpers.ingress.name" -}}
ingress-{{ include "_helpers.fullname" . }}
{{- end }}

{{/*
Certificate name
*/}}
{{- define "_helpers.certificate.name" -}}
certificate-{{ include "_helpers.fullname" . }}
{{- end }}