import module namespace m='http://www.tei-c.org/pm/models/dta/print' at 'dta-print.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/dta.css"],
    "collection": "/db/apps/parzival/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)