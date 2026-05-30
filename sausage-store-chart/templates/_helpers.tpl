{{- define "metadata.labels" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: "{{ .Release.Name }}"
app.kubernetes.io/version: "{{ .Chart.AppVersion }}"
app.kubernetes.io/managed-by: "{{ .Release.Service }}"
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
app.kubernetes.io/part-of: "{{ .Release.Name }}"
{{- end }}

{{- define "template.metadata.labels" }}
{{- include "selector.labels" . }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end }}

{{- define "selector.labels" }}
app.kubernetes.io/instance: "{{ .Release.Name }}"
app.kubernetes.io/name: {{ .Chart.Name }}
{{- end }}

{{- define "vault.init.container" }}
name: vault-secrets
image: {{ .Values.global.vault.image }}
imagePullPolicy: {{ .Values.global.imagePullPolicy }}
env:
  - name: VAULT_ADDR
    value: {{ .Values.global.vault.addr | quote }}
  - name: VAULT_TOKEN
    value: {{ .Values.global.vault.token | quote }}
{{- with .Values.global.vault.resources.container }}
resources:
  {{ toYaml . | nindent 2 }}
{{- end }}
volumeMounts:
  - name: {{ .Values.global.vault.volume }}
    mountPath: {{ .Values.global.secrets }}
{{- end }}
