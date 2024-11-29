package auction_test

import (
	"context"
	"testing"
	"time"

	"fullcycle-auction_go/internal/infra/database/auction"

	"github.com/stretchr/testify/mock"
)

type AuctionRepositoryMock struct {
	mock.Mock
}

func (m *AuctionRepositoryMock) CloseAuction(ctx context.Context, auctionId string) error {
	args := m.Called(ctx, auctionId)
	return args.Error(0)
}

func TestCloseAuctionRoutine(t *testing.T) {
	t.Run("close auction test", func(t *testing.T) {
		repository := &AuctionRepositoryMock{}
		ctx := context.Background()
		repository.On("CloseAuction", ctx, "123").Return(nil)

		closeTime := time.Now().Add(time.Second * 1)
		go auction.CloseAuctionRoutine(ctx, closeTime, "123", repository)
		time.Sleep(time.Millisecond * 100)
		repository.AssertNumberOfCalls(t, "CloseAuction", 0)

		time.Sleep(time.Millisecond * 1900)
		repository.AssertNumberOfCalls(t, "CloseAuction", 1)
		repository.AssertExpectations(t)
	})

	t.Run("context cancellation test", func(t *testing.T) {
		repository := &AuctionRepositoryMock{}
		ctx, cancel := context.WithCancel(context.Background())
		repository.On("CloseAuction", mock.Anything, mock.Anything).Return(nil)

		closeTime := time.Now().Add(time.Second * 1)
		go auction.CloseAuctionRoutine(ctx, closeTime, "123", repository)

		// Cancela o contexto antes de o tempo de fechamento ser atingido
		cancel()
		time.Sleep(time.Second * 2)

		// Verifica que a função CloseAuction NÃO foi chamada
		repository.AssertNotCalled(t, "CloseAuction", mock.Anything, mock.Anything)
	})
}
