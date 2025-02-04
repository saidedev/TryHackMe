<script>
    $('input[name="username"]').keyup(function(){
        $('.userstatus').html('');
        let username = $(this).val();
        // main request part "/register/user-check?username="
        $.getJSON('/register/user-check?username='+ username,function(resp){
            if( resp.available ){
                $('.userstatus').css('color','#80c13d');
                $('.userstatus').html('Username available');
            }else{
                $('.userstatus').css('color','#F00');
                $('.userstatus').html('Username already taken');
            }
        });
    });
</script>