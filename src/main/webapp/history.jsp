<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
  <title>User Activity History</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    h2 {
      color: #333;
    }
    table {
      width: 80%;
      border-collapse: collapse;
      margin-top: 15px;
    }
    table, th, td {
      border: 1px solid #ccc;
    }
    th {
      background: #f2f2f2;
      padding: 10px;
      text-align: left;
    }
    td {
      padding: 8px;
    }
  </style>
</head>
<body>
<h2>User Activity History</h2>

<s:if test="histories != null && !histories.isEmpty()">
  <table>
    <tr>
      <th>ID</th>
      <th>User</th>
      <th>Action</th>
      <th>Details</th>
      <th>Timestamp</th>
    </tr>
    <s:iterator value="histories">
      <tr>
        <td><s:property value="id" /></td>
        <td><s:property value="username" /></td>
        <td><s:property value="action" /></td>
        <td><s:property value="details"/></td>
        <td><s:property value="timestamp" /></td>
      </tr>
    </s:iterator>
  </table>
</s:if>

<s:else>
  <p>No history found.</p>
</s:else>

<br/>
<a href="dashboard.jsp">⬅ Back to Home</a>
</body>
</html>
