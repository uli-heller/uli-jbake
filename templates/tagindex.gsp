<%include "header.gsp"%>

	<%include "menu.gsp"%>
	
        <h2>Themen</h2>
        <ul>
          <% alltags.collect{it-> [it.toLowerCase(), it]}.sort{it-> it[0]}.each { lc, tag ->%>
            <li>
              <a href="${tag}.html">
                  ${lc}
                  (${db.getPublishedPostsByTag(tag).size()})
              </a>
            </li>
	  <%}%>
        </ul>

<%include "footer.gsp"%>
