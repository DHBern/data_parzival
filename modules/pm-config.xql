
xquery version "3.1";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-parzival-web="http://www.tei-c.org/pm/models/parzival/web/module" at "../transform/parzival-web-module.xql";
import module namespace pm-parzival-print="http://www.tei-c.org/pm/models/parzival/print/module" at "../transform/parzival-print-module.xql";
import module namespace pm-parzival-latex="http://www.tei-c.org/pm/models/parzival/latex/module" at "../transform/parzival-latex-module.xql";
import module namespace pm-parzival-epub="http://www.tei-c.org/pm/models/parzival/epub/module" at "../transform/parzival-epub-module.xql";
import module namespace pm-parzival-fo="http://www.tei-c.org/pm/models/parzival/fo/module" at "../transform/parzival-fo-module.xql";
import module namespace pm-docx-tei="http://www.tei-c.org/pm/models/docx/tei/module" at "../transform/docx-tei-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "parzival.odd" return pm-parzival-web:transform($xml, $parameters)
    default return pm-parzival-web:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "parzival.odd" return pm-parzival-print:transform($xml, $parameters)
    default return pm-parzival-print:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "parzival.odd" return pm-parzival-latex:transform($xml, $parameters)
    default return pm-parzival-latex:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "parzival.odd" return pm-parzival-epub:transform($xml, $parameters)
    default return pm-parzival-epub:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:fo-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "parzival.odd" return pm-parzival-fo:transform($xml, $parameters)
    default return pm-parzival-fo:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:tei-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "docx.odd" return pm-docx-tei:transform($xml, $parameters)
    default return error(QName("http://www.tei-c.org/tei-simple/pm-config", "error"), "No default ODD found for output mode tei")
            
    
};
            
    