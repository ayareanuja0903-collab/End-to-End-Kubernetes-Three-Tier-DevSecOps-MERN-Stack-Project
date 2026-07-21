{{/*
Backend chart name
*/}}

{{- define "backend.name" -}}
backend
{{- end }}


{{/*
Create fully qualified app name
*/}}

{{- define "backend.fullname" -}}
{{ include "backend.name" . }}
{{- end }}


{{/*
Common backend labels
*/}}

{{- define "backend.labels" -}}
app: backend
{{- end }}


{{/*
Selector labels
*/}}

{{- define "backend.selectorLabels" -}}
app: backend
{{- end }}
