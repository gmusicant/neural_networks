
	# npm pack: https://www.npmjs.com/package/colors
	colors = require('./node_modules/colors/safe.js')

# helpers

	randomInt = (max) ->
		min = 0
		Math.floor( Math.random() * (max - min) + min )

	flatten = (a) ->
		if a.length is 0 then return []
		a.reduce (lhs, rhs) -> lhs.concat rhs

	invert = (i) ->
		if i is 1 then 0 else 1

	printFlatMask = (flatMask) ->
		for i in [0..6]
			str = ''
			for j in [0..6]
				maskItem = flatMask[(i*7)+j]
				if maskItem
					maskItem = colors.green.bgGreen(maskItem)
				else
					maskItem = colors.red.bgRed(maskItem)
				str = str + maskItem + maskItem
			console.log(str)


# network configuration

	# how many times we have to learh our network
	learnTimes = 100000

	# maximum of mutations on item imputs
	maxMutationOnLearning = 3

	# how fast network have to learn
	learningCoff = 0.1

	# activation function of next layer of neirons
	activationFunction = (sumWeights) ->
		alpha = 0.1
		1 / (1 + Math.exp(-1 * alpha * sumWeights))

	# first time random filling of weight
	randomWeight = () ->
		(randomInt(100)+1)/1000000

	# what we want our network have to know
	idealResults = [
		{
			'name': 'O',
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
			'name': 'I',
			'mask': [
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
			]
		},
		{
			'name': 'T',
			'mask': [
				[0,1,1,1,1,1,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
				[0,0,0,1,0,0,0],
			]
		},
		{
			'name': 'C',
			'mask': [
				[0,0,1,1,1,0,0],
				[0,1,1,0,1,1,0],
				[1,1,0,0,0,0,0],
				[1,0,0,0,0,0,0],
				[1,1,0,0,0,0,0],
				[0,1,1,0,1,1,0],
				[0,0,1,1,1,0,0]
			]
		},
		{
			'name': 'G',
			'mask': [
				[0,0,1,1,1,0,0],
				[0,1,1,0,1,1,0],
				[1,1,0,0,0,0,0],
				[1,0,0,0,1,1,1],
				[1,1,0,0,0,1,1],
				[0,1,1,0,1,1,0],
				[0,0,1,1,1,0,0]
			]
		},
		{
			'name': 'K',
			'mask': [
				[0,1,0,0,1,0,0],
				[0,1,0,1,1,0,0],
				[0,1,0,1,0,0,0],
				[0,1,1,0,0,0,0],
				[0,1,0,1,0,0,0],
				[0,1,0,1,1,0,0],
				[0,1,0,0,1,0,0],
			]
		},
		{
			'name': 'L',
			'mask': [
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,1,1,1,0,0],
			]
		},
		{
			'name': 'M',
			'mask': [
				[1,1,0,0,0,1,1],
				[1,0,1,0,1,0,1],
				[1,0,0,1,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
			]
		},
		{
			'name': 'W',
			'mask': [
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,0,0,0,1],
				[1,0,0,1,0,0,1],
				[1,0,1,0,1,0,1],
				[1,1,0,0,0,1,1],
			]
		},
		{
			'name': 'J',
			'mask': [
				[0,0,0,0,0,1,0],
				[0,0,0,0,0,1,0],
				[0,0,0,0,0,1,0],
				[0,0,0,0,0,1,0],
				[0,0,1,0,0,1,0],
				[0,0,1,0,0,1,0],
				[0,0,0,1,1,0,0],
			]
		},
		{
			'name': 'A',
			'mask': [
				[0,0,0,1,0,0,0],
				[0,0,1,1,1,0,0],
				[0,0,1,0,1,0,0],
				[0,0,1,1,1,0,0],
				[0,1,1,0,1,0,0],
				[0,1,0,0,0,1,0],
				[0,1,0,0,0,1,0],
			]
		},
		{
			'name': 'N',
			'mask': [
				[0,1,1,0,0,1,0],
				[0,1,1,0,0,1,0],
				[0,1,0,1,0,1,0],
				[0,1,0,1,0,1,0],
				[0,1,0,1,0,1,0],
				[0,1,0,0,1,1,0],
				[0,1,0,0,1,1,0],
			]
		},
		{
			'name': 'P',
			'mask': [
				[0,1,1,1,0,0,0],
				[0,1,0,0,1,0,0],
				[0,1,0,0,1,0,0],
				[0,1,1,1,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
				[0,1,0,0,0,0,0],
			]
		},
	]

	# used first one of idealResults. Rename this variable to idealResults if you want to swich to this example
	idealResults2 = [
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

# prepare params

	resultLayerLength = idealResults.length
	inputLayerLength = flatten(idealResults[0].mask).length
	
	idealLayer = (idealItem.name for idealItem in idealResults)

# learning

	# weights count have to be concat of inputLayer * resultLayer

	weights = [] 
	for weightKeyResult in [0..resultLayerLength-1]
		for weightKeyInput in [0..inputLayerLength-1]

			if not weights[weightKeyInput]?
				weights[weightKeyInput] = []

			if not weights[weightKeyInput][weightKeyResult]?
				weights[weightKeyInput][weightKeyResult] = []

			weights[weightKeyInput][weightKeyResult] = randomWeight()

	for i in [0..learnTimes]

		# choose random image 

		randomeKey = randomInt(idealResults.length)
		randomImage = idealResults[randomeKey]

		# preapre expected results
		# all answers will be 0. Only expected result will be 1

		expectResultRow = (0 for [1..resultLayerLength])
		expectResultRow[randomeKey] = 1

		# mutation of ideal image

		flatMask = flatten(randomImage.mask)

		mutationCount = randomInt(maxMutationOnLearning)
		for i in [0..mutationCount]
			flatMaskKey = randomInt(flatMask.length)
			flatMask[flatMaskKey] = invert(flatMask[flatMaskKey])

		# calculation results and update weights

		for weightKeyResult in [0..resultLayerLength-1]

			# calculate sum of weights

			sumWeights = 0
			for weightKeyInput in [0..inputLayerLength-1]
				sumWeights += weights[weightKeyInput][weightKeyResult] * flatMask[weightKeyInput]

			# calculate out of activation function

			perceptronOut = activationFunction(sumWeights)
			expectedResult = expectResultRow[weightKeyResult]

			# calculate delta

			delta = perceptronOut * (1 - perceptronOut) * (expectedResult - perceptronOut)

			# update weights

			for weightKeyInput in [0..inputLayerLength-1]
				weights[weightKeyInput][weightKeyResult] = weights[weightKeyInput][weightKeyResult] + learningCoff * delta * flatMask[weightKeyInput]

# work

	randomeKey = randomInt(idealResults.length)
	randomImage = idealResults[randomeKey]

	console.log('Input: ' + randomImage.name)

	flatMask = flatten(randomImage.mask)

	console.log('ideal:')
	printFlatMask(flatMask)
	
	# mutation of imput image

	for i in [0..maxMutationOnLearning]
		flatMaskKey = randomInt(flatMask.length)
		flatMask[flatMaskKey] = invert(flatMask[flatMaskKey])

	console.log('provided to network:')
	printFlatMask(flatMask)

	# choose the most accurate result

	for weightKeyResult in [0..resultLayerLength-1]

		# calculate sum of weights 

		sumWeights = 0
		for weightKeyInput in [0..inputLayerLength-1] 
			sumWeights += weights[weightKeyInput][weightKeyResult] * flatMask[weightKeyInput]

		# calculate out of activation function

		perceptronOut = activationFunction(sumWeights)

		# choose the moust accurate out of activation function

		if not perceptronLastOut? 
			perceptronLastOut = perceptronOut
			resultKey = weightKeyResult

		if perceptronLastOut < perceptronOut
			perceptronLastOut = perceptronOut
			resultKey = weightKeyResult

	# show results

	if idealResults[resultKey].name == randomImage.name
		console.log('Result is: ' + colors.bgGreen(idealResults[resultKey].name))
	else
		console.log('Result is: ' + colors.bgRed(idealResults[resultKey].name))

	console.log('Result is true for: ', Math.round(perceptronLastOut*10000)/100, '%')

