<% entities.forEach(function(entity) { %>
<%
    var keyAttributes = by(entity.attributes,"isPK","true");
    var notKeyAttributes = byNot(entity.attributes,"isPK","true");
    var isFirst = true;
%>
-- <%=entity.name %>
CREATE TABLE <%=entity.sqlTable%> {
  <% keyAttributes.forEach(function(attr) { %>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    <%=attr.sqlName%> <%=attr.sqlType%><%if(attr.size != null){%>(<%=attr.size%>)<%}%><% if(keyAttributes.length == 1){ %> CONSTRAINT PK_<%=entity.sqlTable%> PRIMARY KEY<% } %>
  <% }) %>
  <% notKeyAttributes.forEach(function(attr) { %>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    <%=attr.sqlName%> <%=attr.sqlType%><%if(attr.size != null){%>(<%=attr.size%>)<%}%><%if(attr.isNotNull=="true"){%> NOT NULL<%}%>
  <% }) %>
  <% if(keyAttributes.length > 1) {%>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    CONSTRAINT PK_<%=entity.sqlTable%> PRIMARY KEY (<%=concat(keyAttributes,",","","",function(attr){return attr.sqlName})%>)
  <% } %>
};
<% }) %>
