<script type="text/javascript" src="js/bootstrap-slider.min.js" charset="UTF-8"></script>
<link href="css/bootstrap-slider.min.css" rel="stylesheet">
			<div class="span10" id="datacontent">
					<table class="table">
						<thead>
							<tr>
								<th colspan="10"></th>
							</tr>
						</thead>
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
				$("#random").slider({
					formatter: function(value) {
						return 'Current Percent: ' + value;
					},
					tooltip: 'always'
				});
				$("#random").on('slideStop', function(e){
    				controlSpeed();
				});
				function test(){
					var x = +document.getElementById("random").value;
					alert(""+x);
					
				}
				</script>
</body>
</html>
