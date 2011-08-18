		function calc_alchol()
		{
			var		form = document.alchol ;
			var		total = (15 * form.weight.value * form.time.value) / (form.type.value * 0.8) ;
			form.total.value = Math.round(total) ;
 
			var		glass = new String() ;
			var		unit  = new String() ;
			var		net ;
			switch(form.type.value) {
				case "5" :						//  ビール
				{ 
					glass = "レギュラー缶" ;
					unit  = "本" ;
					net   = 350 ;
					break ;
				}
				case  "7" :						//  チューハイ
				{
					glass = "サワーグラス" ;
					unit  = "杯" ;
					net   = 200 ;
					break ;
				}
				case "12" :						//  日本酒
				{
					glass = "小徳利" ;
					unit  = "本" ;
					net   = 180 ;
					break ;
				}
				case "15" :						//  ワイン
				{
					glass = "ワイングラス" ;
					unit  = "杯" ;
					net   = 120 ;
					break ;
				}
				case "25" :						//  焼酎
				{
					glass = "焼酎グラス" ;
					unit  = "杯" ;
					net   = 60 ;
					break ;
				}
				case "40" :						//  ウイスキー
				{
					glass = "ショットグラス" ;
					unit  = "杯" ;
					net   = 30 ;
					break ;
				}
				break ;
			}
			var		value = Math.round((total * 10) / net) / 10 ;
			form.glass_name.value  = glass + "(" + net + "ml)" + "で：" ;
			form.glass_value.value = "約" + value + unit ;
		}
