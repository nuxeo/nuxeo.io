{{ define "body"}}
<div class="column left">
<img src="/__static__/error.gif" alt="something went wrong" />
</div>
<div class="column right">
 <h1>Something went wrong.</h1>
 <p>Wait a few seconds and if this message persists contact your application administrator.</p>
 <p>Check your <strong>application status</strong> on the nuxeo.io <a href="%MANAGER_URL%" target="_blank">management console</a>.</p>
 <p>You can also contact the <a href="mailto:feedback-connect@nuxeo.com?subject=[nuxeo.io] Feedback">nuxeo.io team</a>.</p>
</div>
{{end}}
