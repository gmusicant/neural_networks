# issue

# helpers

	randomInt = (max) ->
		min = 0
		Math.floor( Math.random() * (max - min) + min )

	flatten = (a) ->
		if a.length is 0 then return []
		a.reduce (lhs, rhs) -> lhs.concat rhs

	invert = (i) ->
		if i is 1 then 0 else 1

# network configuration

	learnTimes = 10

	maxMutationOnLearning = 3
	activationProcent = 90

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

	resultLayerLength = idealResults.length
	inputLayerLength = flatten(idealResults[0].mask).length
	
	idealLayer = (idealItem.name for idealItem in idealResults)

# learning

	# weights count have to be concat inputLayer x resultLayer

	weights = [] 
	for weightKeyResult in [0..resultLayerLength-1]
		for weightKeyInput in [0..inputLayerLength-1]

			if not weights[weightKeyInput]?
				weights[weightKeyInput] = []

			if not weights[weightKeyInput][weightKeyResult]?
				weights[weightKeyInput][weightKeyResult] = []

			weights[weightKeyInput][weightKeyResult] = (randomInt(100)+1)/1000

	for i in [0..learnTimes]

		randomeKey = randomInt(idealResults.length)
		randomImage = idealResults[randomeKey]

		expectResult = (0 for [1..resultLayerLength])
		expectResult[randomeKey] = 1

		# mutation 

		flatMask = flatten(randomImage.mask)

		mutationCount = randomInt(maxMutationOnLearning)
		for i in [0..mutationCount]
			flatMaskKey = randomInt(flatMask.length)
			flatMask[flatMaskKey] = invert(flatMask[flatMaskKey])

		# calculation results

		actualResult = []
		for weightKeyResult in [0..resultLayerLength-1]

			sumWeights = 0
			for weightKeyInput in [0..inputLayerLength-1]
				sumWeights += weights[weightKeyInput][weightKeyResult] * flatMask[weightKeyInput]

			actualResult[weightKeyResult] = sumWeights
			expectedResultRow = expectResult[weightKeyResult]

			delta = 10 * sumWeights * (1 - sumWeights) * (expectedResultRow - sumWeights)

			for weightKeyInput in [0..inputLayerLength-1]
				console.log(weights[weightKeyInput][weightKeyResult], delta, sumWeights)
				weights[weightKeyInput][weightKeyResult] = weights[weightKeyInput][weightKeyResult] + 0.001 * delta * sumWeights

# work


	randomeKey = randomInt(idealResults.length)
	randomImage = idealResults[randomeKey]

	console.log('Input: ' + randomImage.name)

	expectResult = (0 for [1..resultLayerLength])
	expectResult[randomeKey] = 1

	# mutation 

	flatMask = flatten(randomImage.mask)

	mutationCount = randomInt(maxMutationOnLearning)
	for i in [0..mutationCount]
		flatMaskKey = randomInt(flatMask.length)
		flatMask[flatMaskKey] = invert(flatMask[flatMaskKey])

	for weightKeyResult in [0..resultLayerLength-1]

		sumWeights = 0
		for weightKeyInput in [0..inputLayerLength-1] 
			sumWeights += weights[weightKeyInput][weightKeyResult] * flatMask[weightKeyInput]

		if not maxSumWeight? 
			maxSumWeight = sumWeights
			resultKey = weightKeyResult

		if maxSumWeight < sumWeights
			maxSumWeight = sumWeights
			resultKey = weightKeyResult

	console.log(maxSumWeight)
	console.log('Result: ' + idealResults[resultKey].name)

