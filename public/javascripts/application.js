// application js file
window.addEvent('domready', function() {
	
	if ($("flightOrigin")){
		var complete = new Autocompleter.Ajax.Json($('flightOrigin'), '/airports/search.json', {
			minLength: 1,
		  postVar: 'airport',
		  postData: {}, //additional key/value sets to send with the request
		    ajaxOptions: {method: "get", 
					onRequest: function(){
						$("flightOrigin").addClass("loading");
				}, onFailure: function(){
						$("flightOrigin").removeClass("loading");
				},
					onComplete: function(){
						$("flightOrigin").removeClass("loading");
					}},
			overflow: true,
			injectChoice: function(token) { 
				if (token.error_code) {
					// could not find the one we were looking for
				} else{
					var choice = new Element('li', { html: this.markQueryValue(token.address) }); 
					choice.value = token.id; 
					choice.inputValue = token.address; 
					this.addChoiceEvents(choice).inject(this.choices);
				}
				},

			onSelection: function(el, sel) { 
				$("flight_co2_calculation_origin_airport_id").set('value', sel.value); 
			}
			}).observer.addEvent('onFired', function(val) { 
					if(!val) $("flight_co2_calculation_origin_airport_id").set('value', ''); 
				});
	}
	
	
	if ($("flightDestination")){
		var complete = new Autocompleter.Ajax.Json($('flightDestination'), '/airports/search.json', {
			minLength: 1,
		  postVar: 'airport',
		  postData: {}, //additional key/value sets to send with the request
		    ajaxOptions: {method: "get", 
					onRequest: function(){
						$("flightDestination").addClass("loading");
				}, onFailure: function(){
						$("flightDestination").removeClass("loading");
				},
					onComplete: function(){
						$("flightDestination").removeClass("loading");
					}},
			overflow: true,
			injectChoice: function(token) { 
				if (token.error_code) {
					// could not find the one we were looking for
				} else{
					var choice = new Element('li', { html: this.markQueryValue(token.address) }); 
					choice.value = token.id; 
					choice.inputValue = token.address; 
					this.addChoiceEvents(choice).inject(this.choices);
				}
				},

			onSelection: function(el, sel) { 
				$("flight_co2_calculation_destination_airport_id").set('value', sel.value); 
				}
			}).observer.addEvent('onFired', function(val) { 
					// reset to empty if there is no val
					if(!val) $("flight_co2_calculation_destination_airport_id").set('value', ''); 
				});
	}
	
	// FORM CHECKS
	var myCheck = new FormCheck('carbonCalculator', {
		display : {
			scrollToFirst : false,
			tipsPosition : 'left',
			tipsOffsetX: -60,
			tipsOffsetY: 5
		},
		alerts:{
			required:"Please make sure you have entered an airport.",
		}
	})
});
