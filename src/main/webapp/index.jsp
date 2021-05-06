<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link type="text/css" rel="stylesheet" href="styles.css"/>

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

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

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

                let a = "place" + data[x].row + data[x].cell;
                console.log(a);

                document.getElementById(a).disabled = true;

            }

            // todo берем из выше массив из объектов с полями row и cell - это будут
            // те для которых нужно сделать disabled и добавить текст что занято

            // document.getElementById("place11").disabled = true;

        }).fail(function (err) {
            alert(err);
        });
    });

    function goPayment() {

        let chosenRow;
        let chosenCell;

        const radios = document.getElementsByName('place');
        for (let i = 0, length = radios.length; i < length; i++) {
            if (radios[i].checked) {
                alert(radios[i].value);

                const chosenPlaceStr = radios[i].value;

                chosenRow = chosenPlaceStr.charAt(0);
                chosenCell = chosenPlaceStr.charAt(1);

                break;
            }
        }

        window.location.href = 'http://localhost:8080/cinema/payment.html?id=1&row=' + chosenRow + '&cell=' + chosenCell;
    }

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

                <input id="radio-2" type="radio" name="radio" value="2">

                <td><div class="form_radio_btn"><input type="radio" name="place" value="11" id="place11"><label for="place11">Ряд 1, Место 1</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="12" id="place12"><label for="place12">Ряд 1, Место 2</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="13" id="place13"><label for="place13">Ряд 1, Место 3</label></div></td>
            </tr>
            <tr>
                <th>2</th>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="21" id="place21"><label for="place21">Ряд 2, Место 1</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="22" id="place22"><label for="place22">Ряд 2, Место 2</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="23" id="place23"><label for="place23">Ряд 2, Место 3</label></div></td>
            </tr>
            <tr>
                <th>3</th>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="31" id="place31"><label for="place31">Ряд 3, Место 1</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="32" id="place32"><label for="place32">Ряд 3, Место 2</label></div></td>
                <td><div class="form_radio_btn"><input type="radio" name="place" value="33" id="place33"><label for="place33">Ряд 3, Место 3</label></div></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row float-right">
        <button type="button" class="btn btn-success" onclick="goPayment()">Оплатить</button>
    </div>
</div>
</body>
</html>
