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

<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

<script>
    $(document).ready(function () {

        <%--const el = document.getElementById('citySelector');--%>
        <%--let curCityId = <%=can.getCityId()%>;--%>

        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/cinema/hall',
            dataType: 'json'
        }).done(function (data) {

            console.log(data)

            for (let x = 0; x < data.length; x++) {
                console.log('id =' + data[x].id);
                console.log('row = ' + data[x].row);
                console.log('cell = ' + data[x].cell);
            }

            // window.location.href = 'http://localhost:8080/cinema/payment.html?id=1&row=1&cell=2';
            window.location.href = 'http://localhost:8080/cinema/payment.html?id=1&row=1&cell=2';

        }).fail(function (err) {
            alert(err);
        });
    });
</script>

<div class="container">
    <div class="row pt-3">
        <h4>
            Бронирование мест на сеанс
        </h4>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th style="width: 120px;">Ряд / Место</th>
                <th>1</th>
                <th>2</th>
                <th>3</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th>1</th>
                <td><input type="radio" name="place" value="11"> Ряд 1, Место 1</td>
                <td><input type="radio" name="place" value="11"> Ряд 1, Место 2</td>
                <td><input type="radio" name="place" value="11"> Ряд 1, Место 3</td>
            </tr>
            <tr>
                <th>2</th>
                <td><input type="radio" name="place" value="11"> Ряд 2, Место 1</td>
                <td><input type="radio" name="place" value="11"> Ряд 2, Место 2</td>
                <td><input type="radio" name="place" value="11"> Ряд 2, Место 3</td>
            </tr>
            <tr>
                <th>3</th>
                <td><input type="radio" name="place" value="11"> Ряд 3, Место 1</td>
                <td><input type="radio" name="place" value="11"> Ряд 3, Место 2</td>
                <td><input type="radio" name="place" value="11"> Ряд 3, Место 3</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row float-right">
        <button type="button" class="btn btn-success">Оплатить</button>
    </div>
</div>
</body>
</html>
