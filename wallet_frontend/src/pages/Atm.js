import React, { useState, useEffect } from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import InputLabel from '@mui/material/InputLabel';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';
import Logo from '../assets/tiktokLogo.png';
import QR from '../assets/qr.png';
import { Card, CardContent } from '@mui/material';
import ChatIcon from '@mui/icons-material/Chat';
import NavigateNextIcon from '@mui/icons-material/NavigateNext';

function StatusComponent({ open, onClose }) {
  const [selectedTab, setSelectedTab] = useState('chat');

  const handleTabChange = (tab) => {
    setSelectedTab(tab);
  };

  return (
    <Dialog open={open} onClose={onClose} fullWidth maxWidth="sm">
      <DialogTitle>Status</DialogTitle>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <Button
          variant={selectedTab === 'chat' ? 'contained' : 'outlined'}
          color="secondary"
          onClick={() => handleTabChange('chat')}
        >
          Latest Messages
        </Button>
        <Button
          variant={selectedTab === 'qr' ? 'contained' : 'outlined'}
          color="secondary"
          onClick={() => handleTabChange('qr')}
          style={{ marginLeft: '8px' }}
        >
          QR Code
        </Button>
      </div>
      {/* TODO add chat history */}
      <DialogContent>
        {selectedTab === 'chat' && (
          <div>
                  <Box display={"flex"} flexDirection={"column"}>
        <Box marginX={2} paddingY={2} sx={{ borderBottom: '1px solid', borderColor: 'primary.light' }}>
                <Box display={'flex'}>
                    <Box flexGrow={1} marginTop={1}>
                        <Typography variant='body2'>@John213: Are you near Block 21?</Typography>
                    </Box>
                    <Box marginRight={2} marginY={"auto"}>
                    </Box>
                </Box>
        </Box>
      </Box>
      <Box display={"flex"} flexDirection={"column"}>
        <Box marginX={2} paddingY={2} sx={{ borderBottom: '1px solid', borderColor: 'primary.light' }}>
                <Box display={'flex'}>
                    <Box flexGrow={1} marginTop={1}>
                        <Typography variant='body2'>@Bernard7000: Hi are you still looking to exchange?</Typography>
                    </Box>
                    <Box marginRight={2} marginY={"auto"}>
                    </Box>
                </Box>
        </Box>
      </Box>
      <Box display={"flex"} flexDirection={"column"}>
        <Box marginX={2} paddingY={2} sx={{ borderBottom: '1px solid', borderColor: 'primary.light' }}>
                <Box display={'flex'}>
                    <Box flexGrow={1} marginTop={1}>
                        <Typography variant='body2'>@tina54: I have it!</Typography>
                    </Box>
                    <Box marginRight={2} marginY={"auto"}>
                    </Box>
                </Box>
        </Box>
      </Box>
          </div>
        )}
        {selectedTab === 'qr' && (
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            {/* TODO display live QR code if want */}
            <img src={QR} alt="QR Code" style={{ width: '200px', height: '200px' }} />
          </div>
        )}
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} color="primary">
          Close
        </Button>
      </DialogActions>
    </Dialog>
  );
}

export default function Atm() {
  const [amount, setAmount] = useState('');
  const [currency, setCurrency] = useState('SGD');
  const [recipient, setRecipient] = useState('');
  const [pendingRequests, setPendingRequests] = useState([
    {
      recipient: 'Jowett',
      amount: '54',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Wei Bin',
      amount: '9',
      currency: 'USD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Bernice',
      amount: '2',
      currency: 'JPY',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Yee Sen',
      amount: '2',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Darryl',
      amount: '99',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
  ]);

  useEffect(() => { 
    if (window.localStorage.getItem("authtoken") === null) { 
      window.location.href = '/Login'
    }
  })

  function Atmline(props) {

    return (
      <Box display={"flex"} flexDirection={'column'}>
        <Box marginX={2} paddingY={2} sx={{ borderBottom: '1px solid', borderColor: 'primary.light' }}>
          <Box display={'flex'} alignItems={'center'}>
              <Box textAlign={'left'} flexGrow={1}>
                <Box marginRight={20}>
                    <Typography variant='body2' fontWeight={'bold'}>{props.request.recipient}</Typography>
                </Box>
                <Box >
                    <Typography variant='body2'>{props.request.currency} {props.request.amount}</Typography>
                </Box>
              </Box>
              <Avatar sx={{ bgcolor: 'tertiary.main', color: 'black' }}>
                <Box marginX={'auto'} marginTop={0.5}>
                  <ChatIcon onClick={() => openChatDialog(props.request)} color='white'/>
                </Box>
              </Avatar>
          </Box>
        </Box>
      </Box>
    );
  }

  const Atm = [
    {
      recipient: 'Jowett',
      amount: '5',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Wei Bin',
      amount: '9',
      currency: 'USD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Bernice',
      amount: '2',
      currency: 'JPY',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'YeeSen',
      amount: '2',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
    {
      recipient: 'Darryl',
      amount: '99',
      currency: 'SGD',
      isCurrentUserRequest: false,
    },
  ]
  const [selectedRequest, setSelectedRequest] = useState(null);
  const [openChat, setOpenChat] = useState(false);
  const [chatMessage, setChatMessage] = useState('');
  const [statusDialogOpen, setStatusDialogOpen] = useState(false);
  const [showTransferRequestLine, setShowTransferRequestLine] = useState(false);

  const handleAmountChange = (event) => {
    const inputValue = event.target.value;
    if (/^\d*$/.test(inputValue) || inputValue === '') {
      setAmount(inputValue);
    }
  };

  const handleCurrencyChange = (event) => {
    setCurrency(event.target.value);
  };

  const handleRequestTransfer = () => {
    const newRequest = {
      recipient,
      amount,
      currency,
      isCurrentUserRequest: true,
    };
    setPendingRequests([...pendingRequests, newRequest]);
    setRecipient('');
    setAmount('');
    setCurrency('SGD');
    setShowTransferRequestLine(true);
  };

  const openChatDialog = (request) => {
    setSelectedRequest(request);
    setOpenChat(true);
  };

  const closeChatDialog = () => {
    setOpenChat(false);
    setSelectedRequest(null);
  };

  const handleSendMessage = () => {
    // TODO handle chat
    closeChatDialog();
  };

  const handleStatusButtonClick = () => {
    setStatusDialogOpen(true);
  };

  return (
    <Container marginBottom={16} component="main" maxWidth="xs">
      <Box
        sx={{
          marginTop: '50px',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
        }}
      >
        <Avatar sx={{ m: 1, bgcolor: 'primary.main', color: 'black' }}>
          <Box component="img" src={Logo} height={40}></Box>
        </Avatar>

        <Typography component="h1" variant="h5">
          ATM Transfer
        </Typography>
        <Box component="form" noValidate sx={{ mt: 1 }}>
          <FormControl fullWidth sx={{ mt: 2 }}>
            <InputLabel id="currency-label">Currency</InputLabel>
            <Select
              labelId="currency-label"
              id="currency"
              name="currency"
              label="Currency"
              value={currency}
              onChange={handleCurrencyChange}
            >
              <MenuItem value="SGD">SGD</MenuItem>
              <MenuItem value="USD">USD</MenuItem>
              <MenuItem value="JPY">JPY</MenuItem>
              <MenuItem value="INR">INR</MenuItem>
              <MenuItem value="RUPIAH">RUPIAH</MenuItem>
            </Select>
          </FormControl>

          <TextField
            margin="normal"
            required
            fullWidth
            name="amount"
            label="Amount"
            type="number"
            id="amount"
            value={amount}
            onChange={handleAmountChange}
            sx={{ width: '100%' }}
          />

          <Button
            type="button"
            fullWidth
            color="secondary"
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
            onClick={handleRequestTransfer}
          >
            Request Transfer
          </Button>
        </Box>
      </Box>

      <Box
        sx={{
          // display: 'flex',
          // flexDirection: 'column',
          alignItems: 'center',
          // textAlign: 'center',
          marginTop: 0,
          marginBottom: 0,
        }}
      >

        <Box
          sx={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            textAlign: 'center',
            marginTop: 0,
            marginBottom: 0,
          }}
        >
          {showTransferRequestLine && (
            <Typography marginBottom={3} variant="h6">Your Transfer Requests:</Typography>
          )}
          {pendingRequests
            .filter((request) => request.isCurrentUserRequest)
            .map((request, index) => (
              <Card key={index} variant="outlined" sx={{ mt: 2, px: 8 }}>
                <CardContent>
                  <Typography variant="body1">
                    You requested for: {request.amount} {request.currency}
                  </Typography>
                  <Button
                    variant="outlined"
                    color="secondary"
                    sx={{ mt: 1 }}
                    onClick={handleStatusButtonClick}
                  >
                    Status
                  </Button>
                </CardContent>
              </Card>
            ))}
        </Box>

        <Typography marginTop={4} variant="h6" display={'block'}>Transfer Requests Nearby</Typography>
          <Card variant="outlined">
              <Box justifyContent={"space-evenly"}>
                  {Atm.map((request) => (
                      <Atmline request={request}/>
                  ))}
                  <Box marginY={1} display={"flex"} justifyContent={'center'}>
                      <Typography variant="p" color={"primary"} style={{ textDecoration: 'underline' }}>See more</Typography>
                      <NavigateNextIcon marginY={"auto"}/>
                  </Box>
              </Box>
          </Card>
      </Box>

      <Box marginTop={16}/>

      <StatusComponent open={statusDialogOpen} onClose={() => setStatusDialogOpen(false)} />

      {/* Chat Dialog */}
      <Dialog open={openChat} onClose={closeChatDialog}>
        <DialogTitle>Chat with {selectedRequest?.recipient}</DialogTitle>
        <DialogContent>
          {/* TODO populate chats */}
          <TextField
            margin="normal"
            required
            fullWidth
            multiline
            rows={4}
            variant="outlined"
            label="Message"
            value={chatMessage}
            onChange={(e) => setChatMessage(e.target.value)}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={closeChatDialog} color="primary">
            Cancel
          </Button>
          <Button onClick={handleSendMessage} color="secondary" variant="contained">
            Send Message
          </Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
}
