xquery version "3.1";

(:
    A simple XQuery for an XQueryTrigger that
    logs all trigger events for which it is executed
    in the file /db/triggers-log.xml
    rebuilt to trigger a github action

:)

module namespace trigger="http://exist-db.org/xquery/trigger";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare function local:dispatch-github-action($type as xs:string, $event as xs:string, $uri as xs:string) {
    let $access-token := fn:environment-variable("ACCESS_TOKEN")
    let $repo-owner := "DHBern"
    let $repo-name := "data_parzival"
    let $workflow-name := "EXIST_PUSH"
    let $url := concat("https://api.github.com/repos/", $repo-owner, "/", $repo-name, "/actions/workflows/", $workflow-name, "/dispatches")
    
    let $payload := map {
            "type" : $type,
            "event": $event,
            "uri": $uri
        }
    
    return
        
    hc:send-request(
  <hc:request method='post'>
    <hc:header name="Authorization" select="{concat("Bearer ", $access-token)}" />
    <hc:body media-type="application/json" method="text"/>
  </hc:request>,
  $url,
  serialize($payload, <output:serialization-parameters>
            <output:method>json</output:method>
        </output:serialization-parameters>)
)[2] => util:base64-decode() => parse-json()

};

declare function trigger:after-create-document($uri as xs:anyURI) {
    local:dispatch-github-action("after", "create", $uri)
};

declare function trigger:after-update-document($uri as xs:anyURI) {
    local:dispatch-github-action("after", "update", $uri)
};

declare function trigger:after-copy-document($new-uri as xs:anyURI, $uri as xs:anyURI) {
    local:dispatch-github-action("after", "copy", concat("from: ", $uri, " to: ", $new-uri))
};

declare function trigger:after-move-document($new-uri as xs:anyURI, $uri as xs:anyURI) {
    local:dispatch-github-action("after", "move", concat("from: ", $uri, " to: ", $new-uri))
};

declare function trigger:after-delete-document($uri as xs:anyURI) {
    local:dispatch-github-action("after", "delete", $uri)
};

declare function local:log-event($answer as xs:string) {
    let $log-collection := "/db"
    let $log := "github-log.txt"
    let $log-uri := concat($log-collection, "/", $log)
    return
        (
        (: create the log file if it does not exist :)
        if (not(doc-available($log-uri))) then
            xmldb:store($log-collection, $log, <triggers/>)
        else ()
        ,
        (: log the trigger details to the log file :)
        update insert answer into doc($log-uri)/triggers
        )
};