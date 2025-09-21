<%--
  Created by IntelliJ IDEA.
  User: deca
  Date: 14/09/2025
  Time: 7:48 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fleet Mgmt Menu</title>

  <!-- Inline CSS -->
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #f0f2f5;
      color: #333;
    }

    /* Navbar */
    .navbar {
      background-color: #004466;
      padding: 0 20px;
    }

    .navbar ul {
      list-style: none;
      margin: 0;
      padding: 0;
      display: flex;
      align-items: center;
    }

    .navbar li {
      position: relative;
    }

    .navbar a {
      display: block;
      padding: 12px 15px;
      color: white;
      text-decoration: none;
      font-size: 14px;
      white-space: nowrap;
    }

    .navbar a:hover {
      background-color: #006699;
    }

    .navbar .user-info {
      margin-left: auto;
      color: white;
      font-size: 13px;
      padding: 12px 15px;
    }

    .navbar .user-info a {
      color: #ffd700;
      text-decoration: underline;
      margin-left: 5px;
    }

    .navbar .home-icon {
      margin-left: 15px;
    }

    /* Dropdowns */
    .dropdown-menu,
    .dropdown-submenu {
      display: none;
      position: absolute;
      background: #004466;
      min-width: 200px;
      z-index: 1000;
      border: 1px solid #00334d;
      border-radius: 4px;
      padding: 0;
    }

    .dropdown-submenu {
      top: 0;
      left: 100%;
    }

    .show {
      display: block !important;
    }

    .dropdown-menu a,
    .dropdown-submenu a {
      color: #fff;
      padding: 10px 15px;
      display: block;
      text-decoration: none;
      font-size: 14px;
    }

    .dropdown-menu a:hover,
    .dropdown-submenu a:hover {
      background: #006699;
    }

    /* Breadcrumb */
    .breadcrumb {
      background-color: #e9ecef;
      padding: 10px 15px;
      border-radius: 4px;
      margin: 20px;
      font-size: 14px;
      color: #555;
      border-left: 5px solid #007bff;
    }

    /* Main content */
    .main-content {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 5px;
      padding: 20px;
      margin: 20px;
    }

    /* Tabs */
    .tabs {
      border-bottom: 1px solid #ddd;
      margin-bottom: 20px;
      display: flex;
    }

    .tab-button {
      background-color: #f8f9fa;
      border: 1px solid #ddd;
      border-bottom: none;
      padding: 10px 15px;
      cursor: pointer;
      font-size: 14px;
      border-top-left-radius: 4px;
      border-top-right-radius: 4px;
      margin-right: 5px;
      color: #007bff;
    }

    .tab-button.active {
      background-color: #fff;
      border-color: #ddd;
      border-bottom: 1px solid #fff;
      color: #333;
      font-weight: bold;
    }

    .tab-pane {
      display: none;
    }

    .tab-pane.active {
      display: block;
    }

    /* Form layout */
    .form-section {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px 30px;
      padding: 10px 0;
    }

    .form-row {
      display: flex;
      align-items: center;
      flex-wrap: wrap;
      gap: 5px;
    }

    .form-row.full-width {
      grid-column: 1 / -1;
    }

    .form-row label {
      flex-basis: 120px;
      min-width: 80px;
      font-weight: bold;
      font-size: 14px;
      text-align: right;
      padding-right: 10px;
      white-space: nowrap;
    }

    .form-row input[type="text"],
    .form-row input[type="time"],
    .form-row select,
    .form-row textarea {
      flex-grow: 1;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
      max-width: 250px;
    }

    .form-row textarea {
      min-height: 60px;
      resize: vertical;
      max-width: 100%;
    }

    /* Form actions */
    .form-actions {
      margin-top: 20px;
      padding-top: 15px;
      border-top: 1px solid #eee;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .submit-button {
      background-color: #28a745;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 15px;
      font-weight: bold;
    }

    .submit-button:hover {
      background-color: #218838;
    }

    .action-link {
      color: #007bff;
      text-decoration: none;
      font-size: 14px;
    }

    .action-link:hover {
      text-decoration: underline;
    }

    .compulsory-fields {
      color: #dc3545;
      font-size: 13px;
      margin-left: auto;
    }

    /* Comments Section */
    .comments-section {
      border: 1px solid #ccc;
      border-radius: 4px;
      margin-top: 10px;
      background: #fff;
      width: 100%;
      grid-column: 1 / -1;
    }

    .comments-header {
      background: #f8f9fa;
      padding: 10px 15px;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-weight: bold;
      font-size: 14px;
      border-bottom: 1px solid #ddd;
    }

    .comments-body {
      display: none;
      padding: 15px;
    }

    .expand-icon {
      font-size: 14px;
      transition: transform 0.2s ease-in-out;
    }

    .expand-icon.open {
      transform: rotate(90deg);
    }

    /* Footer */
    .footer {
      background-color: #f8f9fa;
      padding: 15px 20px;
      margin-top: 20px;
      border-top: 1px solid #ddd;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 13px;
      color: #666;
    }

    .footer a {
      color: #007bff;
      text-decoration: none;
    }

    .footer .version {
      font-weight: bold;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .navbar ul {
        flex-wrap: wrap;
        justify-content: center;
      }
      .form-section {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar">
  <ul>
    <li><a href="<s:url value='/dashboard.jsp'/>">DASHBOARD</a></li>
    <li><a href="#">JOURNEY MGMT</a></li>
    <li class="dropdown">
      <a href="#" class="dropdown-toggle">FLEET MGMT ▾</a>
      <ul class="dropdown-menu">
        <li><a href="<s:url value='/vehicle_maintenance_requests.jsp'/>">List Of Vehicles</a></li>
      </ul>
    </li>
    <li class="user-info">
      User: <c:out value="${sessionScope.username}" default="SysServe Solutions"/>
      <a href="<c:url value='/logout'/>">Logout</a>
    </li>
    <li class="home-icon"><a href="<c:url value='/home.jsp'/>">Home</a></li>
  </ul>
</nav>

<!-- Main Container -->
<main class="container">
  <div class="breadcrumb">
    LIST OF VEHICLE MAINTENANCE REQUEST > NEW VEHICLE MAINTENANCE REQUEST
  </div>

  <section class="main-content">
    <!-- Tabs -->
    <div class="tabs">
      <button class="tab-button active" data-tab="details">DETAILS</button>
      <button class="tab-button" data-tab="files">FILES</button>
    </div>

    <!-- Tab Content -->
    <div class="tab-content">
      <div class="tab-pane active" id="details">
        <div class="form-section">
          <div class="form-row full-width">
            <label for="complaint">Complaint*</label>
            <textarea id="complaint" rows="3"></textarea>
          </div>

          <!-- Comments Section -->
          <div class="comments-section">
            <div class="comments-header" onclick="toggleComments()">
              <span>Comments</span>
              <span class="expand-icon" id="expandIcon">&#9654;</span>
            </div>
            <div class="comments-body" id="commentsBody">
              <div class="form-row full-width">
                <label for="comments">Comment</label>
                <textarea id="comments" rows="3"></textarea>
              </div>
              <div class="form-row">
                <label for="assign">Assign</label>
                <select id="assign">
                  <option>--Select--</option>
                  <option>User 1</option>
                </select>
              </div>
              <div class="form-row">
                <label for="notify">Notify</label>
                <select id="notify">
                  <option>--Select--</option>
                  <option>User 1</option>
                </select>
              </div>
              <div class="form-actions">
                <button type="button" class="submit-button">Add</button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Files -->
      <div class="tab-pane" id="files">
        <h3>Upload & Manage Files</h3>
        <input type="file" multiple>
      </div>
    </div>
  </section>
</main>

<!-- Footer -->
<footer class="footer">
  <p>Copyright ©️ <a href="#">SysServe Solutions</a> All Rights Reserved</p>
  <p class="version">Version 10.0.0</p>
</footer>

<script>
  function toggleComments() {
    const body = document.getElementById("commentsBody");
    const icon = document.getElementById("expandIcon");
    if (body.style.display === "block") {
      body.style.display = "none";
      icon.classList.remove("open");
    } else {
      body.style.display = "block";
      icon.classList.add("open");
    }
  }
</script>
</body>
</html>
