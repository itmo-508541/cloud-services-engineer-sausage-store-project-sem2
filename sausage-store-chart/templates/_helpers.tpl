{{- define "metadata.labels" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: "{{ .Release.Name }}"
app.kubernetes.io/version: "{{ .Chart.AppVersion }}"
app.kubernetes.io/managed-by: "{{ .Release.Service }}"
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/part-of: "{{ .Release.Name }}"
{{- end }}

{{- define "selector.labels" }}
app.kubernetes.io/instance: "{{ .Release.Name }}"
app.kubernetes.io/name: {{ .Chart.Name }}
{{- end }}
