
<script type="text/javascript" src="js/bootstrap-slider.min.js" charset="UTF-8"></script>
<script type="text/javascript">
</script>
<link href="css/bootstrap-slider.min.css" rel="stylesheet">
			<div class="span10" id="datacontent">
			<p><b>Inactivate a Node</p>
					<table class="table">
						<tbody>
							<tr>
								<td class="span3"><input id="random" name="random" type="text" data-slider-id='ex1Slider' data-slider-min="0" data-slider-max="1" data-slider-step="0.1" data-slider-value="0"/></td>
								<td class="span10">
									When current percent is 1, it means every 2 seconds, a node becomes inactive. 
								</td>
							</tr>
						</tbody>
					</table>
		</div>
				<script type="text/javascript">
				document.getElementById('random').setAttribute("data-slider-value",speed);
				$("#random").slider({
					formatter: function(value) {
						return 'Current Percent: ' + value;
					},
					tooltip: 'always'
				});
				$("#random").on('slideStop', function(e){
    				speed = document.getElementById('random').value;
					if (speed != "") {
						createXMLHttp() ;
						xmlHttp.open("POST","inactivateNode?speed="+speed) ;
						xmlHttp.send() ;
						updateSpeed.update();
					}
				});
  				var updateSpeed = {  
					update : function() {
							var data = {
								"speed" : speed
							};
							var mydata = JSON.stringify(data);
							$.ajax({
								type : "POST",
								url :"speedSession",
								data : mydata,
								contentType : 'application/json;charset=UTF-8'
							});
						}
					}
				</script>
</body>
</html>
