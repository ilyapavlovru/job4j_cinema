<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Сервис - Кинотеатр</title>
</head>
<body>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script>
    const url_string = window.location.href;
    const url = new URL(url_string);
    const chosenSessionId = url.searchParams.get("session_id");
    const chosenRow = url.searchParams.get("row");
    const chosenCell = url.searchParams.get("cell");

    $(document).ready(function () {
        const orderHeader = document.getElementById('orderHeader');
        orderHeader.textContent = 'Вы выбрали ряд ' + chosenRow + ' место ' + chosenCell + ', Сумма : 500 рублей';
        document.getElementById("session_id").value = chosenSessionId;
        document.getElementById("row").value = chosenRow;
        document.getElementById("cell").value = chosenCell;
    });

    function validate() {
        const name = $('#username').val();
        if (name === "") {
            alert("Укажите ваше имя");
            return false;
        }
        const phone = $('#phone').val();
        if (phone === "") {
            alert("Укажите ваш телефон");
            return false;
        }
    }
</script>

<div class="container">
    <div class="row pt-3">
        <h3 id="orderHeader"></h3>
    </div>
    <div class="row">
        <form action="<%=request.getContextPath()%>/ticket.do" method="post">
            <div class="form-group">
                <label for="username">Имя</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="Имя">
            </div>
            <div class="form-group">
                <label for="phone">Номер телефона</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="Номер телефона">
            </div>
            <input type="hidden" id="session_id" name="session_id"/>
            <input type="hidden" id="row" name="row"/>
            <input type="hidden" id="cell" name="cell"/>
            <button type="submit" class="btn btn-success" onclick="return validate()">Оплатить</button>
        </form>
    </div>
</div>
</body>
</html>
