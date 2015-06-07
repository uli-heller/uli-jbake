<%include "header.gsp"%>

	<%include "menu.gsp"%>
	
        <h2>Themen</h2>
        <% alltags.collect{it-> [it.toLowerCase(), it]}.sort{it-> it[0]}.each { lc, tag ->%>	
          <a href="${tag}.html">${lc}</a> 
	<%}%>

<%include "footer.gsp"%>
