# issue

# network configuration

	learnTimes = 5

	idealResults = [
		{
			'name': 'square',
			'mask': [
				[1,1,1,1,1,1,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,1,1,1,1,1,1],
			]
		},
		{
			'name': 'circle',
			'mask': [
				[0,0,1,1,1,0,0],
				[0,1,1,0,1,1,0],
				[1,1,0,0,0,1,1],
				[1,0,0,0,0,0,1],
				[1,1,0,0,0,1,1],
				[0,1,1,0,1,1,0],
				[0,0,1,1,1,0,0]
			]
		},
		{
			'name': 'triangle',
			'mask': [
				[0,0,0,1,0,0,0],
				[0,0,1,0,1,0,0],
				[0,0,1,0,1,0,0],
				[0,1,0,0,0,1,0],
				[0,1,0,0,0,1,0],
				[1,0,0,0,0,0,1],
				[1,1,1,1,1,1,1]
			]
		},
		{
			'name': 'diamond',
			'mask': [
				[0,0,0,1,0,0,0],
				[0,0,1,0,1,0,0],
				[0,1,0,0,0,1,0],
				[1,0,0,0,0,0,1],
				[0,1,0,0,0,1,0],
				[0,0,1,0,1,0,0],
				[0,0,0,1,0,0,0]
			]
		}
	]

# helpers

	randomInt = (max) ->
		min = 0
		Math.floor( Math.random() * (max - min) + min )

# learning

	for i in [0..learnTimes]

		randomeKey = randomInt(idealResults.length)
		randomImage = idealResults[randomeKey]

		# mutation 

		for maskRow, maskRowKey in randomImage.mask
			
			# max random value excluded. Here will be 0/1
			if randomInt(2) == 1

				maskItemKey = randomInt(maskRow.length)
				if randomImage.mask[maskRowKey][maskItemKey] == 1
					randomImage.mask[maskRowKey][maskItemKey] = 0
				else
					randomImage.mask[maskRowKey][maskItemKey] = 1

		

# work