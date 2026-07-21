{{/*
Frontend chart name
*/}}

{{- define "frontend.name" -}}
frontend
{{- end }}


{{/*
Create fully qualified frontend name
*/}}

{{- define "frontend.fullname" -}}
{{ include "frontend.name" . }}
{{- end }}


{{/*
Common labels
*/}}

{{- define "frontend.labels" -}}
app.kubernetes.io/name: {{ include "frontend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Selector labels
*/}}

{{- define "frontend.selectorLabels" -}}
app: frontend
{{- end }}


{{/*
Service account name
*/}}

{{- define "frontend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ default (include "frontend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
