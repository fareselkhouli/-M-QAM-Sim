function y=channel(modStream,snr)
    y = awgn(modStream,snr,'measured');