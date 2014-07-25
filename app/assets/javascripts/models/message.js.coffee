Twitchpluschat.Message = DS.Model.extend
  userName: DS.attr('string')
  text: DS.attr('string')
  timestamp: DS.attr('date')

Twitchpluschat.Message.FIXTURES = [
  {
    id: 1,
    userName: 'Aveil',
    text: 'Hey there',
    timestamp: new Date('Wed Jul 02 2014 03:36:54 GMT+0100 (BST)')
  },
  {
    id: 2,
    userName: 'Arteezy',
    text: 'How are you doing brah',
    timestamp: new Date('Wed Jul 02 2014 03:46:54 GMT+0100 (BST)')
  },
  {
    id: 3,
    userName: 'Aveil',
    text: 'Kappa',
    timestamp: new Date('Wed Jul 02 2014 03:56:54 GMT+0100 (BST)')
  },
  {
    id: 4,
    userName: 'AdmiralBulldog'
    text: 'Lappa',
    timestamp: new Date('Wed Jul 02 2014 03:57:54 GMT+0100 (BST)')
  },
  {
    id: 5,
    userName: 'Sing'
    text: 'Fock Keepo',
    timestamp: new Date('Wed Jul 02 2014 03:58:54 GMT+0100 (BST)')
  }
]
