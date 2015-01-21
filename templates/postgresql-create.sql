-- postgresql


<% each(entities, function(entity) { %>
<%
  var entity = clone(entity);

  var keyAttributes = by(entity.attributes,"isPK","true");
  var notKeyAttributes = byNot(entity.attributes,"isPK","true");
  var isFirst = true;

  each(entity.attributes, function(attr) {
    if(attr.sqlName == null) {
      attr.sqlName = attr.name.a();
    }
    if(attr.sqlType == null) {
      if(attr.type.a() == 'string') {
        attr.sqlType = 'varchar()';
      }
      else if(attr.type.a() == 'integer') {
        attr.sqlType = 'integer';
      }
      else if(attr.type.a() == 'long') {
        attr.sqlType = 'numeric';
      }
      else if(attr.type.a() == 'date') {
        attr.sqlType = 'date';
      }
      else {
        attr.sqlType = '???';
      }
    }
  });
%>
-- <%=entity.name %>
CREATE TABLE <%= (entity.sqlTable != null) ? entity.sqlTable : entity.name.a() %> (
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
);
<% }) %>
