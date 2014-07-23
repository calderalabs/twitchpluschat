Twitchpluschat.Message = DS.Model.extend
  text: DS.attr('string')
  timestamp: DS.attr('date')

Twitchpluschat.Message.FIXTURES = [
  { id: 1, text: 'Hey there', timestamp: new Date('Wed Jul 02 2014 03:36:54 GMT+0100 (BST)') },
  { id: 2, text: 'How are you doing brah', timestamp: new Date('Wed Jul 02 2014 03:46:54 GMT+0100 (BST)') },
  { id: 3, text: 'Kappa', timestamp: new Date('Wed Jul 02 2014 03:56:54 GMT+0100 (BST)') },
  { id: 4, text: 'Lappa', timestamp: new Date('Wed Jul 02 2014 03:57:54 GMT+0100 (BST)') },
  { id: 5, text: 'Keepo', timestamp: new Date('Wed Jul 02 2014 03:58:54 GMT+0100 (BST)') }
]
