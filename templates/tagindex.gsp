<%include "header.gsp"%>

	<%include "menu.gsp"%>
	
        <h2>Themen</h2>
        <div data-i2="fontSize:['8pt','20pt']">
          <% alltags.collect{it-> [it.toLowerCase(), it]}.sort{it-> it[0]}.each { lc, tag ->%>
	    <% int count = db.getPublishedPostsByTag(tag).size(); %>
            <span data-i2="rate:${db.getPublishedPostsByTag(tag).size()}">
              <a href="${tag}.html">${lc}(${count})</a>
            </span>
	  <%}%>
        </div>
  <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/i2ui-1.0.0.js"></script>
  <script>i2.emph()</script>
<%include "footer.gsp"%>
