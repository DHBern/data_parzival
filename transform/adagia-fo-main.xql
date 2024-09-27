import module namespace m='http://www.tei-c.org/pm/models/adagia/fo' at 'adagia-fo.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/adagia.css"],
    "collection": "/db/apps/parzival/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)