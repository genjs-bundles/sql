<% each(entities, function(entity) { %>
<%
    var keyAttributes = by(entity.attributes,"isPK","true");
    var notKeyAttributes = byNot(entity.attributes,"isPK","true");
    var isFirst = true;
%>
-- <%=entity.name %>
CREATE TABLE <%= (entity.sqlTable != null) ? entity.sqlTable : entity.name.a() %> {
  <% each(keyAttributes, function(attr) { %>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    <%=attr.sqlName%> <%=attr.sqlType%><%if(attr.size != null){%>(<%=attr.size%>)<%}%><% if(keyAttributes.length == 1){ %> CONSTRAINT PK_<%=entity.sqlTable%> PRIMARY KEY<% } %>
  <% }) %>
  <% each(notKeyAttributes, function(attr) { %>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    <%=attr.sqlName%> <%=attr.sqlType%><%if(attr.size != null){%>(<%=attr.size%>)<%}%><%if(attr.isNotNull=="true"){%> NOT NULL<%}%>
  <% }) %>
  <% if(keyAttributes.length > 1) {%>
    <% if(isFirst){isFirst=false;}else{%>,<%}%>
    CONSTRAINT PK_<%=entity.sqlTable%> PRIMARY KEY (<%=concat(keyAttributes,",","","",function(attr){return attr.sqlName})%>)
  <% } %>
};
<% }) %>
