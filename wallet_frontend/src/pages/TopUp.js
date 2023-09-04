import * as React from 'react';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import FormControl from '@mui/material/FormControl';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import Select from '@mui/material/Select';

const theme = createTheme({
  palette: {
    primary: {
      main: '#EE1D52'
    },
  },
});

export default function TopUp() {
  const handleTopUp = () => {
    // TODO handle topup
  };

  // TODO take from db
  const bankAccounts = [
    {
      type: 'Linked Bank Account',
      last4Digits: '5678',
    },
    {
      type: 'Savings Account',
      last4Digits: '9876',
    },
  ];

  const cards = [
    {
      type: 'Debit Card',
      last4Digits: '4321',
    },
    {
      type: 'Credit Card',
      last4Digits: '1234',
    },
  ];

  const [selectedCard, setSelectedCard] = React.useState(cards[0].type);
  const [selectedBankAccount, setSelectedBankAccount] = React.useState(bankAccounts[0].type);

  const handleCardChange = (event) => {
    setSelectedCard(event.target.value);
  };

  const handleBankAccountChange = (event) => {
    setSelectedBankAccount(event.target.value);
  };
    // TODO handle add new card and add new bank account
  return (
    <ThemeProvider theme={theme}>
      <Container component="main" maxWidth="xs">
        <div
          style={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            marginTop: '64px',
          }}
        >
          <Typography component="h1" variant="h5" style={{ marginTop: '16px' }}>
            Top Up Your Card
          </Typography>
          <div
            style={{
              width: '100%',
              marginTop: '24px',
            }}
          >
            <form>
              <FormControl fullWidth variant="outlined" style={{ marginTop: '16px' }}>
                <TextField
                  autoComplete="amount"
                  name="amount"
                  required
                  fullWidth
                  id="amount"
                  label="Amount to top up"
                  autoFocus
                  variant="outlined"
                />
              </FormControl>
              <Button
                type="button"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
                onClick={handleTopUp}
              >
                Top Up
              </Button>
            </form>
          </div>
        </div>
        <div
          style={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            marginTop: '32px',
          }}
        >
        </div>
      </Container>
    </ThemeProvider>
  );
}
