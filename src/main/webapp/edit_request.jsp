<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Edit Maintenance Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #004466;
            margin-bottom: 25px;
        }

        .form-row {
            margin-bottom: 18px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #333;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            background: #fafafa;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, textarea:focus, select:focus {
            border-color: #007bff;
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        .btn-submit {
            display: inline-block;
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .btn-submit:hover {
            background: #0056b3;
        }

        .back-link {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #555;
            font-size: 14px;
        }

        .back-link:hover {
            color: #007bff;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Maintenance Record</h2>

    <s:form action="updateRequest" method="post">
        <s:hidden name="record.id"/>

        <div class="form-row">
            <s:textfield name="record.office" label="Office"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.client" label="Client"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.vehicle" label="Vehicle"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.mileageDate" label="Mileage Date"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.mileageTime" label="Mileage Time"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.driver" label="Driver"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.location" label="Location"/>
        </div>
        <div class="form-row">
            <s:textfield name="record.faultType" label="Fault Type"/>
        </div>
        <div class="form-row">
            <s:textarea name="record.complaint" label="Complaint"/>
        </div>
        <div class="form-row">
            <s:select name="record.status" list="{'Pending','Started','Complete'}" label="Status"/>
        </div>

        <s:submit cssClass="btn-submit" value="Save Changes"/>
    </s:form>

    <a href="listRequests.action" class="back-link">← Back to List</a>
</div>
</body>
</html>
